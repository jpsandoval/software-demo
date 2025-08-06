require 'net/http'
require 'json'
require 'uri'

API_BASE = 'https://software-demo-u56y.onrender.com/api/students' # or your production URL

class Student
  attr_reader :id, :nickname, :age, :house, :grade,
              :hobby, :favorite_color, :pet_name, :pet_kind

  def initialize(data)
    @id = data["id"]
    @nickname = data["nickname"]
    @age = data["age"]
    @house = data["house"]
    @grade = data["grade"]
    @hobby = data["hobby"]
    @favorite_color = data["favorite_color"]
    @pet_name = data["pet_name"]
    @pet_kind = data["pet_kind"]
  end

  def to_s
    "#{@nickname} (#{@house}, Grade: #{@grade})"
  end
end

class StudentAPIClient
  def initialize(api_url)
    @uri = URI(api_url)
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @http.use_ssl = @uri.scheme == 'https'
  end

  def list_students
    request = Net::HTTP::Get.new(@uri)
    request['Accept'] = 'application/json'

    response = @http.request(request)

    if response.is_a?(Net::HTTPSuccess)
      students = JSON.parse(response.body).map { |data| Student.new(data) }
      puts "List of students:"
      students.each { |student| puts "- #{student}" }
    else
      puts "Failed to fetch students (#{response.code})"
      puts response.body
    end
  end

  def create_student(data)
    request = Net::HTTP::Post.new(@uri.path)
    request['Content-Type'] = 'application/json'
    request['Accept'] = 'application/json'
    request.body = { student: data }.to_json

    response = @http.request(request)

    if response.is_a?(Net::HTTPSuccess) || response.code == '201'
      student = Student.new(JSON.parse(response.body))
      puts "Student created: #{student}"
    else
      puts "Failed to create student (#{response.code})"
      puts response.body
    end
  end
end

# ======================
# Example usage
# ======================

client = StudentAPIClient.new(API_BASE)

client.create_student({
  nickname: "Wizard2025",
  age: 15,
  house: "Gryffindor",
  grade: 6.0,
  hobby: "wand collecting",
  favorite_color: "blue",
  pet_name: "Nimbus",
  pet_kind: "owl"
})
