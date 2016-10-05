require 'station'


describe Station do

 subject(:mudchute) {described_class.new(:station, :zone_num)}

  it "A station has a name" do
    expect(subject.station_name).to eq :station
  end

  it "A station has a zone" do
    expect(subject.zone).to eq :zone_num
  end

end
