
describe HideMyAss::Proxy::Base do
  let!(:proxy) { described_class.new(nil) }

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
      let(:anonymity) { 0 }
      it('is not anonym') { expect(proxy.anonym?).to be false }
    end

    context 'medium' do
      let(:anonymity) { 1 }
      it('is anonym') { expect(proxy.anonym?).to be true }
    end

    context 'high' do
      let(:anonymity) { 2 }
      it('is anonym') { expect(proxy.anonym?).to be true }
    end
  end

  describe 'security' do
    before { allow(proxy).to receive(:anonymity).and_return 1 }

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

  describe '#url' do
    context 'when ip = 1.0.0.1 and port = 80' do
      before do
        allow(proxy).to receive(:ip).and_return '1.0.0.1'
        allow(proxy).to receive(:port).and_return 80
      end

      it('relative url is 1.0.0.1:80') do
        expect(proxy.rel_url).to eq('1.0.0.1:80')
      end

      context 'and protocol is http' do
        before { allow(proxy).to receive(:protocol).and_return 'http' }

        it('url is http://1.0.0.1:80') do
          expect(proxy.url).to eq('http://1.0.0.1:80')
        end
      end
    end
  end
end
