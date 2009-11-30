#Designed to be included into Abingo::Experiment, but you can feel free to adapt this
#to anything you want.

module Abingo::Statistics

  HANDY_Z_SCORE_CHEATSHEET = [[0.10, 1.29], [0.05, 1.65], [0.01, 2.33], [0.001, 3.08]]

  PERCENTAGES = {0.10 => '90%', 0.05 => '95%', 0.01 => '99%', 0.001 => '99.9%'}

  DESCRIPTION_IN_WORDS = {0.10 => 'fairly confident', 0.05 => 'confident',
                         0.01 => 'very confident', 0.001 => 'extremely confident'}
  def zscore
    alternatives_for_zscore = top_2_alternatives

    if (alternatives_for_zscore[0].participants == 0) || (alternatives_for_zscore[1].participants == 0)
      raise "Can't calculate the z score if either of the alternatives lacks participants."
    end

    cr1 = alternatives_for_zscore[0].conversion_rate
    cr2 = alternatives_for_zscore[1].conversion_rate

    n1 = alternatives_for_zscore[0].participants
    n2 = alternatives_for_zscore[1].participants

    numerator = cr1 - cr2
    frac1 = cr1 * (1 - cr1) / n1
    frac2 = cr2 * (1 - cr1) / n2

    numerator / ((frac1 + frac2) ** 0.5)
  end

  def top_2_alternatives
    alternatives_with_participants = alternatives.reject {|a| a.conversion_rate.nan? }
    sorted_alternatives = alternatives_with_participants.sort {|a,b| b.conversion_rate <=> a.conversion_rate }
    sorted_alternatives.slice(0,2)
  end

  def p_value
    index = 0
    z = zscore
    z = z.abs
    found_p = nil
    while index < HANDY_Z_SCORE_CHEATSHEET.size do
      if (z > HANDY_Z_SCORE_CHEATSHEET[index][1])
        found_p = HANDY_Z_SCORE_CHEATSHEET[index][0]
      end
      index += 1
    end
    found_p
  end

  def is_statistically_significant?(p = 0.05)
    p_value <= p
  end

  def pretty_conversion_rate
    sprintf("%4.2f%%", conversion_rate * 100)
  end

  def describe_result_in_words
    alternatives_to_describe = top_2_alternatives
    begin
      z = zscore
    rescue
      return "Could not execute the significance test because one or more of the alternatives has not been seen yet."
    end
    p = p_value

    best  = alternatives_to_describe[0]
    worst = alternatives_to_describe[1]

    words = ""
    if (best.participants < 10) || (worst.participants < 10)
      words += "Take these results with a grain of salt since your samples are so small: "
    end

    words += "The best alternative you have is: [#{best.content}], which had "
    words += "#{best.conversions} conversions from #{best.participants} participants "
    words += "(#{best.pretty_conversion_rate}).  The other alternative was [#{worst.content}], "
    words += "which had #{worst.conversions} conversions from #{worst.participants} participants "
    words += "(#{worst.pretty_conversion_rate}).  "

    if (p.nil?)
      words += "However, this difference is not statistically significant."
    else
      words += "This difference is #{PERCENTAGES[p]} likely to be statistically significant, which means you can be "
      words += "#{DESCRIPTION_IN_WORDS[p]} that it is the result of your alternatives actually mattering, rather than "
      words += "being due to random chance.  However, this statistical test can't measure how likely the currently "
      words += "observed magnitude of the difference is to be accurate or not.  It only says \"better\", not \"better "
      words += "by so much\"."
    end
    words
  end

end