function htmlCode = generateHTMLrep(cell_array)
    display(cell_array);
    htmlCode = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Frameset//EN" "http://www.w3.org/TR/html4/frameset.dtd">';
    htmlCode = [htmlCode,'<HTML LANG="EN"><HEAD><TITLE>'];
    htmlCode = [htmlCode,'</TITLE></HEAD><BODY STYLE="font-family: Arial, Helvetica, sans-serif; font-size: 8px;"><TABLE CELLSPACING="0" CELLPADDING="0" BORDER="0">'];
    for i=1:size(cell_array,1)
        htmlCode = [htmlCode,'<TR>'];
        for j=1:size(cell_array,2)
            htmlCode = [htmlCode,'<TD>',string(cell_array(i,j)),'</TD>']; 
        end
        htmlCode = [htmlCode,'</TR>'];
    end
    htmlCode = [htmlCode,'</TABLE></BODY></HTML>'];
    htmlCode = strjoin(htmlCode);
end
