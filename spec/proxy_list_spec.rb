
describe HideMyAss::ProxyList do
  context 'when initialized with sample fixture' do
    let!(:list_1) { IO.read('spec/fixtures/list.1.html') }
    let!(:list_2) { IO.read('spec/fixtures/list.2.html') }

    before do
      stub_request(:post, %r{hidemyass.com/$}).and_return body: list_1
      stub_request(:post, %r{hidemyass.com/2$}).and_return body: list_2
    end

    it('contains 83 proxies') { expect(subject.count).to eq(83) }
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
