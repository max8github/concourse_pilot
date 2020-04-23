module ConcoursePilot
  RSpec.describe Task do
    describe "#valid" do
      let(:task_data_minimal) do
        {
          "platform" => "linux",
          "image_resource" => {
            "type" => "docker-image",
            "source" => {
              "repository" => "ruby",
              "tag" => "2.1",
            },
          },
          "run" => {
            "path" => "ls",
          },
        }
      end
      let(:task_data_unexpected_key) do
        {
          "platform" => "linux",
          "pipeline" => "continuous-integration",
          "image_resource" => {
            "type" => "docker-image",
            "source" => {
              "repository" => "ruby",
              "tag" => "2.1",
            },
          },
          "run" => {
            "path" => "ls",
          },
        }
      end
      let(:task_data_missing_platform) do
        {
          "image_resource" => {
            "type" => "docker-image",
            "source" => {
              "repository" => "ruby",
              "tag" => "2.1",
            },
          },
          "run" => {
            "path" => "ls",
          },
        }
      end
      it "returns true on a valid pipeline" do
        expect(Task.new(task_data_minimal).valid?).to eq true
      end
      it "returns false when unexpected key exists" do
        expect(Task.new(task_data_unexpected_key).valid?).to eq false
      end
      it "returns false when required key is missing" do
        expect(Task.new(task_data_missing_platform).valid?).to eq false
      end
    end
    describe ".inputs / .outputs" do
      let(:task_with_io) do
        {
          "platform" => "linux",
          "inputs" => [
            {
              "name" => "foo",
            },
          ],
          "image_resource" => {
            "type" => "docker-image",
            "source" => {
              "repository" => "ruby",
              "tag" => "2.1",
            },
          },
          "run" => {
            "path" => "ls",
          },
        }
      end
      subject { Task.new(task_with_io) }
      it "list out inputs and outputs" do
        expect(subject.inputs).to eq([{"name" => "foo"}])
        expect(subject.outputs).to eq([])
      end
    end
    describe ".from_yaml" do
      let(:task_yaml_valid) do
        <<~YAML
          ---
          platform: linux

          image_resource:
            type: docker-image
            source:
              repository: ruby
              tag: '2.1'

          run:
            path: ls
        YAML
      end
      it "loads a valid YAML just fine" do
        expect { Task.from_yaml(task_yaml_valid) }.not_to raise_error
      end
    end
  end
end
