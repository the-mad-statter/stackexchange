function Note(note)
  return pandoc.walk_inline(note, {Cite = function(cit)
      if (cit.citations[1].mode=='NormalCitation') and (#cit.content > 1) then 
        if cit.content[2].text=='(' then
          cit.content[2].text='';
        end
        if cit.content[#cit.content].text==')' then
          cit.content[#cit.content].text=''
        end
      end
    return cit
  end})
end