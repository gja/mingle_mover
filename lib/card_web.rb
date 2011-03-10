module CardWeb
  def style
    return 'color: red' if $ugly_status.include? status
    return 'color: green' if $good_status.include? status
    'color: black'
  end
end
