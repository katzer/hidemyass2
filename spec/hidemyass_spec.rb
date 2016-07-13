
describe HideMyAss do
  it 'has a version number' do
    expect(HideMyAss::VERSION).not_to be nil
  end

  before do
    stub_request(:get, /incloak.com/).and_timeout
    stub_request(:get, /hidester.com/).and_timeout
  end

  context 'when asking for proxies' do
    let!(:list) { HideMyAss.proxies }

    it('returns a list of proxies') do
      expect(list).to be_a HideMyAss::ProxyList
    end

    context 'when asking for cached list again' do
      subject { HideMyAss.proxies! }
      it('returns the same list') { is_expected.to be(list) }
    end

    context 'when asking for a new list' do
      subject { HideMyAss.proxies }
      it('returns a new list') { is_expected.not_to be(list) }
    end

    context 'with filter (socks only)' do
      let!(:list_1) { IO.read('spec/fixtures/hide_me.list.html') }
      let!(:list_2) { IO.read('spec/fixtures/hidester.list.json') }

      before do
        stub_request(:get, /incloak.com/).and_return body: list_1
        stub_request(:get, /hidester.com/).and_return body: list_2
      end

      before { HideMyAss.proxies(&:socks?) }

      it('contains proxies') { expect(HideMyAss.proxies!).to be_any }

      it('contains only socks proxies ') do
        expect(HideMyAss.proxies!.one?(&:socks?)).to be false
      end
    end
  end
end
