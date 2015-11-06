module LogsHelper
  def is_own_log?(log)
    log.user == current_user
  end

  def create_cc_entry(user, passwd, sport, tsession, log)
    type = sport
    e = 'entry'+type

    builder = Nokogiri::XML::Builder.new do |xml|
      xml.send(e) {
        xml.send(:'entrylocation', tsession.location)
        xml.send(:'entryduration', tsession.duration)
        xml.send(:'entrydate', tsession.datetime.to_datetime)
        xml.send(:'commentt', 'Test')
        xml.send(:'publicvisible', 2)
        if type == 'running' or type == 'cycling'
          xml.send(:'coursetype', tsession.level)
          xml.send(:'courslength', tsession.length)
        end
        if type == 'cycling'
          xml.send(:'bicycletype', 'Bike')
        end
      }
    end

    r = builder.to_xml
    r.gsub! 'commentt', 'comment'

    begin
      digest = Base64.encode64(user+':'+passwd)
      url = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/users/#{user}/#{sport}"
      doc = RestClient.post url, r, :content_type => :xml, :Authorization => "Basic #{digest}"

      Rails.logger.debug("answer: #{doc}")

        #doc = Nokogiri::XML(result)

    rescue Exception => e
      status=false
      Rails.logger.debug("error: #{e}")
    end
  end

  def delete_cc_entry(user, passwd, sport, entryid)
    begin
      digest = Base64.encode64(user+':'+passwd)
      url = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/users/#{user}/#{sport}/#{entryid}"
      doc = RestClient.delete url, :Authorization => "Basic #{digest}"
    end
  end

  def get_last_cc_entry(user, passwd, sport)

    entry_path = 'entry'+sport

    begin
      digest = Base64.encode64(user+':'+passwd)
      url = "http://diufvm31.unifr.ch:8090/CyberCoachServer/resources/users/#{user}/#{sport}"
      doc = RestClient.get url, :Authorization => "Basic #{digest}"

      #Rails.logger.debug("answer: #{doc}")

      result = Nokogiri::XML(doc)
      result = result.root

      items = result.xpath('entries/'+entry_path)

      if not items[0].nil?
        highest_item = items.max{ |a,b| a["id"] <=> b["id"] }
        highest = highest_item["id"]
      else
        highest = 0
      end

      return highest
    rescue Exception => e
      status=false
      #Rails.logger.debug("error: #{e}")
      return 0
    end
  end
end