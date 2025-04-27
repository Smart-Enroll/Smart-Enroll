term       = "Summer 2026"

courses    = [
  "cis4250 - Ethical Issues",
  "cis3260 - Software Engineering",
  "cis3300 - Database Design",
  "cis3410 - Algorithms",
  "cis3420 - Operating Systems",
  "cis3500 - Computer Networks",
  "cis3600 - Software Testing",
  "cis3700 - AI Foundations",
  "cis3800 - Web Development",
  "cis3900 - Mobile App Development"
]

professors = %w[Smith Johnson Lee García Patel Brown Davis Miller Wilson Moore]

# Pick 10 unique courses and seed them
courses.shuffle.first(10).each do |class_tag_name|
  crn         = rand(100_000..999_999)
  start_hour  = rand(8..16)
  class_time  = Time.current.change(hour: start_hour, min: 0)
  end_time    = class_time + 1.hour

  # pick 1–5 random weekdays
  days = %i[mon tue wed thu fri].sample(rand(1..5))

  Course.create!(
    CRN:          crn,
    class_name:   class_tag_name,
    professor:    "Dr. #{professors.sample}",
    term:         term,
    credits:      [1, 2, 3, 4].sample,
    class_time:   class_time,
    end_time:     end_time,
    status:       "Open",
    prerequisite: "None",
    capacity:     [20, 25, 30].sample,
    major:        %w[CS ENG MATH BIO].sample,
    mon:          days.include?(:mon),
    tue:          days.include?(:tue),
    wed:          days.include?(:wed),
    thu:          days.include?(:thu),
    fri:          days.include?(:fri)
  )
end
