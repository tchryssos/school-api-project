require 'rails_helper'

RSpec.describe Teacher, type: :model do

  let(:teacher){teacher= Teacher.create(name: "Mr. Smee", subject: "Geography")}

  it 'is valid witih a name and subject' do
    expect(teacher).to be_valid
  end

  it 'is not valid without a name' do
    nameless_teacher=Teacher.create(subject: "Black Arts")

    expect(nameless_teacher).to_not be_valid
    expect(nameless_teacher.errors["name"]).to include("can't be blank")
  end

  it "is not valid without a subject" do
    subjectless_teacher = Teacher.create(name: "Ms. Honey")

    expect(subjectless_teacher).to_not be_valid
    expect(subjectless_teacher.errors["subject"]).to include("can't be blank")
  end

  it 'is valid with a quote' do
    new_quote="There's a lot of bees in my office."

    teacher.quote=new_quote
    expect(teacher.quote).to eq("There's a lot of bees in my office.")
    expect(teacher).to be_valid
  end

  it 'get a new student' do
    bobby= Student.create(name: "Bobby", grade: 10)
    teacher.students<<bobby
    teacher.reload
    expect(teacher.students).to include(bobby)
    expect(teacher).to be_valid
  end
end
