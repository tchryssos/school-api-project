require 'rails_helper'

RSpec.describe Student, type: :model do

let(:student){student=Student.create(name:"Bobby", grade: 9, quote: "I hate school.")}

it 'is valid with name and grade' do
  expect(student).to be_valid
end

it 'is not valid without name' do
  nameless_student=Student.create(grade: 10)

  expect(nameless_student).to_not be_valid
  expect(nameless_student.errors["name"]).to include("can't be blank")
end

it 'is not valid without grade' do
  gradeless_student=Student.create(name: "Robert Yilby")

  expect(gradeless_student).to_not be_valid
  expect(gradeless_student.errors["grade"]).to include("can't be blank")
end

it 'is valid without a quote' do
  quoteless_student= Student.create(name:"Bobby", grade: 9)
  expect(quoteless_student).to be_valid
end

it 'can get a new teacher' do
  teacher=Teacher.create(name: "Mr. Pitt", subject: "Music")

  student.teachers<<teacher

  student.reload

  expect(student.teachers.size).to eq(1)
  expect(student.teachers.first.name).to eq("Mr. Pitt")
end



end
