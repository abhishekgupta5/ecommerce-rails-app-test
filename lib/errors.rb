module Errors
  class ErpClientError < StandardError
    def message
      "Client error. Fix the request and try again"
    end
  end

  class ErpServerError < StandardError
    def message
      "Something gone bad on our end"
    end
  end
end
