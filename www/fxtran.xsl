<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:f="http://fxtran.net/#syntax"
 xmlns:html="http://www.w3.org/1999/xhtml">

  <xsl:output method="xml"/>

  <xsl:template match="*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="/f:object">

<html:style>
file 
{
  white-space: pre;
  font-weight: bold;
  font-family: monospace;
  line-height: 0px;
}

C
{
  color: blue;
}

n 
{
  font-weight: normal;
}

cnt
{
  color: red;
}

include
{
  color: green;
  font-weight: bold;
}

</html:style>

<html:script><![CDATA[

function foldCall (call)
{

}

function _onload ()
{

  let nsResolver = function(prefix) 
  {
      const ns = {
        'f': 'http://fxtran.net/#syntax'
      };
      return ns[prefix] || null;
  };
 
  
  let ns;
  ns = document.evaluate ('//f:file', document, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
  
  let f = ns.snapshotItem (0);
  
  f.insertBefore (document.createTextNode ("\n"), f.firstChild);
    
  ns = document.evaluate ('//f:file//text()[contains(.,"\n")]', document, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
                
  let I = 1;                            
  for (let i = 0; i < ns.snapshotLength; i++)
    {
      let s = ns.snapshotItem (i);
      let t = s.textContent;
      let tt = t.split (/\n/).reverse ();

      let t1 = tt.shift ();
      s.parentNode.insertBefore (document.createTextNode (t1), s.nextSibling);  
          
      for (t of tt)
        {

          let L = document.createElementNS ("http://fxtran.net/#syntax", "L");
          L.appendChild (document.createTextNode (("0000" + I).slice (-4) + " | "));
          s.parentNode.insertBefore (L, s.nextSibling);
          s.parentNode.insertBefore (document.createTextNode (t + "\n"), s.nextSibling);
          I++;

        }
      

        
      s.parentNode.removeChild (s);

    }
    
  f.removeChild (f.firstChild);
  f.removeChild (f.lastChild);
  
  let type = "stmt";
  let size = type.length;
  //ns = document.evaluate ('//f:file//*[substring(name(),string-length(name())-' + size + ')="-' + type + '"]', 
  //                        document, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null); 

  ns = document.evaluate ('//f:file//f:call-stmt', 
                          document, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null); 
  
  for (let i = 0; i < ns.snapshotLength; i++)
    {
      let x = ns.snapshotItem (i);
      console.log (x);
      x.addEventListener ('click', function (e) { console.log (e); console.log ("CALL"); x.remove ();  });
    }

  document.addEventListener ('click', function (e) { console.log (e); console.log ("DOCUMENT"); });
}


]]></html:script>

<html:body onload="_onload()">

    <xsl:apply-templates/>

</html:body>

  </xsl:template>

</xsl:stylesheet>

