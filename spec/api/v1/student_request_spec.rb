require 'rails_helper'

describe "School API" do

  describe "/students" do
    it 'returns a JSON selection of all of the students' do
      Student.create(name: "Juan", grade: 11)
      Student.create(name: "Shakira", grade: 12)
      Student.create(name: "Ian", grade: 11)
      get '/api/v1/students'
      response_body=JSON.parse(response.body)
      expect(response).to be_success
      expect(response_body.length).to eq(3)
    end
  end

    describe '/students/:id' do
      it 'returns a JSON selection of one student' do

        student=Student.create(name:"Sarah", grade: 5)

        get "/api/v1/students/#{student.id}"
        response_body=JSON.parse(response.body)

        # expect(response_body.length).to eq(1)
        expect(response).to be_success
        expect(response_body["name"]).to eq("Sarah")
        expect(response_body["id"]).to eq(student.id)
      end
    end

    describe 'post /students' do
      it 'creates a new student and returns JSON for that student' do

        post '/api/v1/students/', {student: {name:"Boomhauer", grade: 12, quote: "You want the dang ol' truth?, man I'll tell you the dang ol' truth."}}

        response_body=JSON.parse(response.body)

        expect(Student.all.length).to eq(1)
        expect(response).to be_success
        expect(Student.all.first.name).to eq("Boomhauer")
        expect(response_body["id"]).to eq(Student.all.first.id)
        expect(response_body["name"]).to eq("Boomhauer")

      end

      context 'when invalid' do
        it 'returns an error status and message' do

          post '/api/v1/students', {student: {name: "Dale"}}
          response_body=JSON.parse(response.body)

          expect(response.status).to eq(500)
          expect(response_body).to eq({"grade" => ["can't be blank"]})
        end
      end
    end

    describe 'patch /students/:id' do
      it 'Updates specified student with supplied information and returns the JSON collection for that student' do
        student=Student.create(name: "Abe Linky", grade: 4)
        patch "/api/v1/students/#{student.id}", {student: {name: "Abraham Lincoln"}}

        response_body=JSON.parse(response.body)
        updated_student=Student.find(student.id)

        expect(response).to be_success
        expect(student.name).to eq("Abe Linky")
        expect(updated_student.name).to eq("Abraham Lincoln")
        expect(updated_student.id).to eq(student.id)
        expect(response_body["name"]).to include("Abraham Lincoln")
        expect(response_body["id"]).to eq(student.id)
      end
    end

    describe 'delete /students/:id' do
      context 'it exists' do
        it "Deletes specified student" do
          student=Student.create(name:"Goby", grade: 6)
          delete "/api/v1/students/#{student.id}"

          expect(response).to be_success
          expect(Student.count).to eq(0)
        end
      end

    context 'it does not exist' do
      it 'sends an error message and status' do
        delete "/api/v1/students/400"

        response_body=JSON.parse(response.body)


        expect(response.status).to eq(404)
        expect(response_body).to eq({"error"=>"student with id of 400 not found"})
      end
    end
  end


  end
