
describe HideMyAss::ProxyList do
  context 'when initialized with sample fixture' do
    let!(:list) { IO.read('spec/fixtures/list.html') }

    before do
      stub_request(:get, /incloak.com/).and_return body: list
    end

    it('contains 64 proxies') { expect(subject.count).to eq(64) }

    it('contains 21 proxies with http support') do
      expect(subject.find_all(&:http?).count).to eq(21)
    end

    it('contains 4 proxies with https support') do
      expect(subject.find_all(&:https?).count).to eq(4)
    end

    it('contains 39 proxie with socks support') do
      expect(subject.find_all(&:socks?).count).to eq(39)
    end

    it('contains 43 proxies with socks support') do
      expect(subject.find_all(&:ssl?).count).to eq(43)
    end

    it('contains 48 proxies with high anonymity') do
      expect(subject.find_all(&:anonym?).count).to eq(48)
    end

    it('contains 42 secure proxies') do
      expect(subject.find_all(&:secure?).count).to eq(42)
    end
  end

  context 'when network is offline' do
    before { stub_request(:get, /incloak.com/).and_timeout }
    it('contains 0 proxies') { expect(subject.count).to eq(0) }
  end

  context 'when response fails' do
    before { stub_request(:get, /incloak.com/).and_return status: 402 }
    it('contains 0 proxies') { expect(subject.count).to eq(0) }
  end
end
