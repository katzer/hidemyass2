require 'timecop'

describe HideMyAss::Proxy::Hidester do
  let!(:row) { JSON.load(IO.read('spec/fixtures/hidester.row.json')) }
  let!(:proxy) { described_class.new(row) }

  before { Timecop.freeze(Time.utc(2016, 7, 13, 13, 0, 0)) }

  context 'when initialized with sample fixture' do
    it('last check is 20 minute ago') { expect(proxy.last_check).to eq(20) }
    it('ip is 216.110.244.48') { expect(proxy.ip).to eq('216.110.244.48') }
    it('port is 48111') { expect(proxy.port).to eq(48_111) }
    it('country is Canada') { expect(proxy.country).to eq('canada') }
    it('speed is 141') { expect(proxy.speed).to eq(141) }
    it('protocol is SOCKS5') { expect(proxy.protocol).to eq('socks5') }
    it('anonymity is high') { expect(proxy.anonymity).to eq(2) }
  end
end
