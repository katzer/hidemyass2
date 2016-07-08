
describe HideMyAss::ProxyList do
  context 'when initialized with sample fixture' do
    let!(:list_1) { IO.read('spec/fixtures/list.1.html') }
    let!(:list_2) { IO.read('spec/fixtures/list.2.html') }

    before do
      stub_request(:post, %r{hidemyass.com/$}).and_return body: list_1
      stub_request(:post, %r{hidemyass.com/2$}).and_return body: list_2
    end

    it('contains 83 proxies') { expect(subject.count).to eq(83) }

    it('contains 73 proxies with http support') do
      expect(subject.find_all(&:http?).count).to eq(73)
    end

    it('contains 9 proxies with https support') do
      expect(subject.find_all(&:https?).count).to eq(9)
    end

    it('contains 1 proxie with socks support') do
      expect(subject.find_all(&:socks?).count).to eq(1)
    end

    it('contains 10 proxies with socks support') do
      expect(subject.find_all(&:ssl?).count).to eq(10)
    end

    it('contains 82 proxies with high anonymity') do
      expect(subject.find_all(&:anonym?).count).to eq(82)
    end

    it('contains 82 secure proxies') do
      expect(subject.find_all(&:secure?).count).to eq(10)
    end
  end

  context 'when network is offline' do
    before { stub_request(:post, /hidemyass/).and_timeout }
    it('contains 0 proxies') { expect(subject.count).to eq(0) }
  end

  context 'when response fails' do
    before { stub_request(:post, /hidemyass/).and_return status: 402 }
    it('contains 0 proxies') { expect(subject.count).to eq(0) }
  end
end
