FactoryBot.define do
  factory :job do
    title {"Job Title"}
    description {"Title Description"}
    experience_required {15}
    educational_qualification {"Btech"}
    location {"location"}
    job_type { :part_time } 
    closing_date { 1.week.from_now }
    category
  end
end
