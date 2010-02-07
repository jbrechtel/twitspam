module HamlHelper

  def js(filename)
    if filename.match /^http/ then "<script type='text/javascript' src='#{filename}'></script>" 
    else "<script type='text/javascript' src='scripts/#{filename}'></script>" end
  end

  def css(filename)
    if filename.match /^http/ then "<link rel='stylesheet' type='text/css' href='#{filename}'/>" 
    else "<link rel='stylesheet' type='text/css' href='styles/#{filename}'/>" end    
  end
end