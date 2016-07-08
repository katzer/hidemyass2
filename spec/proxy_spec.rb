
describe HideMyAss::Proxy do
  let!(:row) { Nokogiri::XML(IO.read('spec/fixtures/row.html')).child }
  let!(:proxy) { described_class.new(row) }

  context 'when initialized with sample fixture' do
    it('last_update is 77102') { expect(proxy.last_updated).to eq(77_102) }
    it('ip is 62.38.52.56') { expect(proxy.ip).to eq('62.38.52.56') }
    it('port is 8080') { expect(proxy.port).to eq(8080) }
    it('country is Greece') { expect(proxy.country).to eq('Greece') }
    it('speed is 2180') { expect(proxy.speed).to eq(2180) }
    it('connection time is 56') { expect(proxy.connection_time).to eq(56) }
    it('protocol is http') { expect(proxy.protocol).to eq('http') }
    it('anonymity is High+KA') { expect(proxy.anonymity).to eq('High +KA') }
    it('url correct') { expect(proxy.url).to eq('http://62.38.52.56:8080') }
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
