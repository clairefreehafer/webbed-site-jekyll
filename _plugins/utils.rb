module AnimalCrossing
  def self.get_star_fragment(date)
    month = date.month
    day = date.day

    astrologyDateRanges = {
      :capricorn => "1222-0119",
      :aquarius => "0120-0218",
      :pisces => "0219-0320",
      :aries => "0321-0419",
      :taurus => "0420-0520",
      :gemini => "0521-0621",
      :cancer => "0622-0722",
      :leo => "0723-0822",
      :virgo => "0823-0922",
      :libra => "0923-1023",
      :scorpio => "1024-1122",
      :sagittarius => "1123-1221"
    }

    case month
    when 1
      if day <= 19 then
        astrologyDateRanges[:capricorn]
      else
        astrologyDateRanges[:aquarius]
      end
    when 2
      if day <= 18 then
        astrologyDateRanges[:aquarius]
      else
        astrologyDateRanges[:pisces]
      end
    when 3
      if day <= 20 then
        astrologyDateRanges[:pisces]
      else
        astrologyDateRanges[:aries]
      end
    when 4
      if day <= 19 then
        astrologyDateRanges[:aries]
      else
        astrologyDateRanges[:taurus]
      end
    when 5
      if day <= 20 then
        astrologyDateRanges[:taurus]
      else
        astrologyDateRanges[:gemini]
      end
    when 6
      if day <= 21 then
        astrologyDateRanges[:gemini]
      else
        astrologyDateRanges[:cancer]
      end
    when 7
      if day <= 22 then
        astrologyDateRanges[:cancer]
      else
        astrologyDateRanges[:leo]
      end
    when 8
      if day <= 22 then
        astrologyDateRanges[:leo]
      else
        astrologyDateRanges[:virgo]
      end
    when 9
      if day <= 22
        astrologyDateRanges[:virgo]
      else
        astrologyDateRanges[:libra]
      end
    when 10
      if day <= 23
        astrologyDateRanges[:libra]
      else
        astrologyDateRanges[:scorpio]
      end
    when 11
      if day <= 22
        astrologyDateRanges[:scorpio]
      else
        astrologyDateRanges[:sagittarius]
      end
    when 12
      if day <= 21
        astrologyDateRanges[:sagittarius]
      else
        astrologyDateRanges[:capricorn]
      end
    end
  end
end