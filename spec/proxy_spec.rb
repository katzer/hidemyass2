
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
end
