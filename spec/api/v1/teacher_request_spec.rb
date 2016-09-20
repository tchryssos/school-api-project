require 'rails_helper'

describe "School API" do

  describe "/teachers" do
    it 'returns a JSON selection of all of the teachers' do
      Teacher.create(name: "Ms. Jackson", subject: "AP US History")
      Teacher.create(name: "Mo-T", subject: "AP European History")
      Teacher.create(name: "Mahlke", subject: "MAC")
      get '/api/v1/teachers'
      response_body=JSON.parse(response.body)
      expect(response).to be_success
      expect(response_body.length).to eq(3)
    end
  end

    describe '/teachers/:id' do
      it 'returns a JSON selection of one teacher' do

        teacher=Teacher.create(name:"Mrs. Obama", subject: "Politics")

        get "/api/v1/teachers/#{teacher.id}"
        response_body=JSON.parse(response.body)

        # binding.pry

        # expect(response_body.length).to eq(1)
        expect(response).to be_success
        expect(response_body["name"]).to eq("Mrs. Obama")
        expect(response_body["id"]).to eq(teacher.id)
      end
    end

    describe 'post /teachers' do
      it 'creates a new teacher and returns JSON for that teacher' do

        post '/api/v1/teachers/', {teacher: {name:"Hal Halpern", subject: "American History", quote: "I'm the evil twin."}}

        response_body=JSON.parse(response.body)

        expect(Teacher.all.length).to eq(1)
        expect(response).to be_success
        expect(Teacher.all.first.name).to eq("Hal Halpern")
        expect(response_body["id"]).to eq(Teacher.all.first.id)
        expect(response_body["name"]).to eq("Hal Halpern")

      end

      context 'when invalid' do
        it 'returns an error status and message' do

          post '/api/v1/teachers', {teacher: {name: "Dr. Seuss"}}
          response_body=JSON.parse(response.body)

          expect(response.status).to eq(500)
          expect(response_body).to eq({"subject" => ["can't be blank"]})
        end
      end
    end

    describe 'patch /teachers/:id' do
      it 'Updates specified teacher with supplied information and returns the JSON collection for that teacher' do
        teacher=Teacher.create(name: "Mr. Richardson", subject: "Wind Ensemble")
        patch "/api/v1/teachers/#{teacher.id}", {teacher: {name: "Richie"}}

        response_body=JSON.parse(response.body)
        updated_teacher=Teacher.find(teacher.id)

        expect(response).to be_success
        expect(teacher.name).to eq("Mr. Richardson")
        expect(updated_teacher.name).to eq("Richie")
        expect(updated_teacher.id).to eq(teacher.id)
        expect(response_body["name"]).to include("Richie")
        expect(response_body["id"]).to eq(teacher.id)
      end
    end

    describe 'delete /teachers/:id' do
      context 'it exists' do
        it "Deletes specified teacher" do
          teacher=Teacher.create(name:"Sra. Campos McGuire", subject: "Spanish")
          delete "/api/v1/teachers/#{teacher.id}"

          expect(response).to be_success
          expect(Teacher.count).to eq(0)
        end
      end

    context 'it does not exist' do
      it 'sends an error message and status' do
        delete "/api/v1/teachers/400"

        response_body=JSON.parse(response.body)


        expect(response.status).to eq(404)
        expect(response_body).to eq({"error"=>"teacher with id of 400 not found"})
      end
    end
  end


  end
