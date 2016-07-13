
describe HideMyAss::Proxy::HideMe do
  let!(:row) { Nokogiri::XML(IO.read('spec/fixtures/hide_me.row.html')).child }
  let!(:proxy) { described_class.new(row) }

  context 'when initialized with sample fixture' do
    it('last check is 1 minute ago') { expect(proxy.last_check).to eq(1) }
    it('ip is 146.0.253.113') { expect(proxy.ip).to eq('146.0.253.113') }
    it('port is 1080') { expect(proxy.port).to eq(1080) }
    it('country is Germany') { expect(proxy.country).to eq('germany') }
    it('speed is 260') { expect(proxy.speed).to eq(260) }
    it('protocol is SOCKS4') { expect(proxy.protocol).to eq('socks4') }
    it('anonymity is high') { expect(proxy.anonymity).to eq('high') }
  end
end
