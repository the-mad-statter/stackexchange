function Note(note)
  return pandoc.walk_inline(note, {Cite = function(cit)
      if (cit.citations[1].mode=='NormalCitation') and (#cit.content > 1) then
        if cit.content[1].t == 'Space' then
          table.remove(cit.content, 1) -- remove space and shift everything left
        end
        if cit.content[1].t == 'Str' and cit.content[1].text=='(' then
          cit.content[1].text='';
        end
        if cit.content[#cit.content].text==')' then
          cit.content[#cit.content].text=''
        end
      end
    return cit
  end})
end