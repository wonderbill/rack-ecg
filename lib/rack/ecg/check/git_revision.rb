module Rack
  class ECG
    module Check
      class GitRevision
        def result
          _stdin, stdout, stderr, wait_thread = Open3.popen3("git rev-parse HEAD")

          success = wait_thread.value.success?

          value = success ? stdout.read : stderr.read
          value = value.strip

          Result.new(:git_revision, success, value)
        end
      end

      CheckRegistry.instance.register(:git_revision, GitRevision)

    end
  end
end
