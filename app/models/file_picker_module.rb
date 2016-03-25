require 'rest_client'

module FilePickerModule

  def self.upload_picture(attachment)
    types = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif']
    result = FilePickerModule.upload attachment
    if types.include? result[:type]
      result
    else
      FilePickerModule.delete result[:url]
      { error: "Invalid format. Only these types are supported: #{types}" }
    end
  end

  def self.upload_text_file(attachment)
    result = FilePickerModule.upload attachment
    if result[:type] == 'text/plain'
      result
    else
      FilePickerModule.delete result[:url]
      { error: "Invalid format. Only text files are supported" }
    end
  end

  def self.delete(url)
    final_url = url[0...8] + "www" + url[11...url.length]
    RestClient.delete "#{final_url}?key=#{$filepicker_api_key}"
  end

  private
    def self.upload(file_input)
      # Upload file
      remote_url = "#{$filepicker_root}/store/S3?key=#{$filepicker_api_key}"
      response = RestClient.post remote_url, fileUpload: file_input
      jsonResponse = JSON.parse(response)
      url = jsonResponse['url']
      filename = jsonResponse['filename']
      type = jsonResponse['type']

      {url: url, filename: filename, type: type }
    end
end
