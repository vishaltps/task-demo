# frozen_string_literal: true

FactoryBot.define do
  factory :task_tag do
    task { create(:task) }
    tag { create(:tag) }
  end
end
