
describe HideMyAss::Proxy do
  let!(:row) { Nokogiri::XML(IO.read('spec/fixtures/row.html')).child }
  let!(:proxy) { described_class.new(row) }

  context 'when initialized with sample fixture' do
    it('last check is 1 minute ago') { expect(proxy.last_check).to eq(1) }
    it('ip is 146.0.253.113') { expect(proxy.ip).to eq('146.0.253.113') }
    it('port is 1080') { expect(proxy.port).to eq(1080) }
    it('country is Germany') { expect(proxy.country).to eq('germany') }
    it('speed is 260') { expect(proxy.speed).to eq(260) }
    it('protocol is SOCKS4') { expect(proxy.protocol).to eq('socks4') }
    it('anonymity is high') { expect(proxy.anonymity).to eq('high') }
    it('url correct') { expect(proxy.url).to eq('socks4://146.0.253.113:1080') }
  end

  describe 'SSL support' do
    context 'when protocol is http' do
      before { allow(proxy).to receive(:protocol).and_return 'http' }
      it('is not supported') { expect(proxy.ssl?).to be false }
    end

    context 'when protocol is https' do
      before { allow(proxy).to receive(:protocol).and_return 'https' }
      it('is supported') { expect(proxy.ssl?).to be true }
    end

    context 'when protocol is socks' do
      before { allow(proxy).to receive(:protocol).and_return 'socks4/5' }
      it('is supported') { expect(proxy.ssl?).to be true }
    end
  end

  describe 'anonymity' do
    before { allow(proxy).to receive(:anonymity).and_return anonymity }

    context 'low' do
      let(:anonymity) { 'low' }
      it('is not anonym') { expect(proxy.anonym?).to be false }
    end

    context 'medium' do
      let(:anonymity) { 'medium' }
      it('is not anonym') { expect(proxy.anonym?).to be false }
    end

    context 'high' do
      let(:anonymity) { 'high' }
      it('is anonym') { expect(proxy.anonym?).to be true }
    end
  end

  describe 'security' do
    context 'when protocol is HTTP' do
      before { allow(proxy).to receive(:protocol).and_return 'http' }
      it('is not secure') { expect(proxy.secure?).to be false }
    end

    context 'when network is not anonym' do
      before { allow(proxy).to receive(:anonym?).and_return false }
      it('is not secure') { expect(proxy.secure?).to be false }
    end

    context 'when network is anonym and protocol supports SSL' do
      before do
        allow(proxy).to receive(:anonym?).and_return true
        allow(proxy).to receive(:ssl?).and_return true
      end

      it('is secure') { expect(proxy.secure?).to be true }
    end
  end
end
