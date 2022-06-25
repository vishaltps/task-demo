# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TaskTag, type: :model do
  it { is_expected.to belong_to(:task) }
  it { is_expected.to belong_to(:tag) }
end
