# frozen_string_literal: true

RSpec.describe EntityReport do
  it "has a version number" do
    expect(EntityReport::VERSION).not_to be nil
  end
end
