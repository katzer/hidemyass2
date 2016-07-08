
describe HideMyAss do
  it 'has a version number' do
    expect(HideMyAss::VERSION).not_to be nil
  end

  describe '::form_data' do
    context 'when trying to set data of invalid type' do
      it 'raises an argument error' do
        expect { HideMyAss.form_data = [] }.to raise_error(ArgumentError)
      end
    end

    context 'when setting some data' do
      let!(:form_data) { { spec: 123 } }
      before { HideMyAss.form_data = form_data }

      context 'and getting the data after' do
        it 'returns the new form data' do
          expect(HideMyAss.form_data).to eq(form_data)
        end
      end
    end

    before { stub_request(:post, /hidemyass/).and_timeout }

    context 'when asking for all proxies' do
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
    end
  end
end
