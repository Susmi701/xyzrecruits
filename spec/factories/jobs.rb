FactoryBot.define do
  factory :job do
    sequence(:title) { |n| "Job Title #{n}" }
    description {"Title Description"}
    experience_required {15}
    educational_qualification {"Btech"}
    location {"location"}
    job_type { :part_time } 
    closing_date { 1.week.from_now }
    category
  end
end
