
describe HideMyAss::ProxyList do
  context 'when initialized with sample fixture' do
    let!(:list_1) { IO.read('spec/fixtures/hide_me.list.html') }
    let!(:list_2) { IO.read('spec/fixtures/hidester.list.json') }

    before do
      stub_request(:get, /incloak.com/).and_return body: list_1
      stub_request(:get, /hidester.com/).and_return body: list_2
    end

    it('contains 162 proxies') { expect(subject.count).to eq(162) }

    it('contains 70 proxies with http support') do
      expect(subject.find_all(&:http?).count).to eq(70)
    end

    it('contains 4 proxies with https support') do
      expect(subject.find_all(&:https?).count).to eq(4)
    end

    it('contains 88 proxie with socks support') do
      expect(subject.find_all(&:socks?).count).to eq(88)
    end

    it('contains 92 proxies with socks support') do
      expect(subject.find_all(&:ssl?).count).to eq(92)
    end

    it('contains 123 proxies with high anonymity') do
      expect(subject.find_all(&:anonym?).count).to eq(123)
    end

    it('contains 89 secure proxies') do
      expect(subject.find_all(&:secure?).count).to eq(89)
    end
  end

  context 'when network is offline' do
    before do
      stub_request(:get, /incloak.com/).and_timeout
      stub_request(:get, /hidester.com/).and_timeout
    end

    it('contains 0 proxies') { expect(subject.count).to eq(0) }
  end

  context 'when response fails' do
    before do
      stub_request(:get, /incloak.com/).and_return status: 402
      stub_request(:get, /hidester.com/).and_return status: 402
    end

    it('contains 0 proxies') { expect(subject.count).to eq(0) }
  end
end
