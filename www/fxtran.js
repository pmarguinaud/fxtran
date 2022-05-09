var fxtranURI = 'http://fxtran.net/#syntax';
var htmlURI = 'http://www.w3.org/1999/xhtml';

function parseHTML (html)
{
  var doc = document.implementation.createHTMLDocument ('');
  doc.documentElement.innerHTML = html;
  return doc.body.firstChild;
}

function nsResolver (prefix) 
{
  const ns = {'f': fxtranURI, 'html': htmlURI};
  return ns[prefix] || null;
}
 
function ucFirst (s) 
{
  return s.charAt (0).toUpperCase () + s.slice (1);
}

function NClick (n)
{
  let t = n.textContent;
  let ns = document.evaluate ('//f:N[string(.)="' + t + '"]', 
                               document, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, 
                               null);
  console.log (n);
  console.log (n.parentNode);

  if (n.parentNode.namespaceURI == htmlURI)
    {
      
      for (let i = 0; i < ns.snapshotLength; i++)
        {
          let s = ns.snapshotItem (i);
          if (s.parentNode.namespaceURI == htmlURI)
            {
              s.parentNode.replaceWith (s);
            }
        }
    }
  else
    {
      let TT = parseHTML ('<tt style="background-color:red;"/>');

      for (let i = 0; i < ns.snapshotLength; i++)
        {
          let s = ns.snapshotItem (i);
          let t = TT.cloneNode (true);
          t.appendChild (s.cloneNode (true));
          s.replaceWith (t);
        }
    }
}

function methodExists (method)
{
  return eval ('typeof ' + method + ' == "function"');
}

function methodCall (method, n, e)
{
  return eval (method + ' (n, e)');
}

function findTarget (methodSuffix, n)
{
  while (n) 
    {
      if (n.namespaceURI == fxtranURI)
        {
          let nn = n.nodeName.split ('-');
          for (let i = 1; i < nn.length; i++)
            {
              nn[i] = ucFirst (nn[i]);
            }

          let method = nn.join ('') + methodSuffix;

          if (methodExists (method))
            {
              return {"node": n, "method": method};
            }
        }
      n = n.parentNode;
    }

}

function _onclick (e)
{
  let n = e.target;

  console.log ("_onclick = ", e);

  let a = findTarget ('Click', n);

  if (a)
    {
      methodCall (a["method"], a["node"], e);
    }
}

function getContextMenu (e, h)
{
  let menu = parseHTML ('<div class="menu"/>');

  for (k in h)
    {
      let a = parseHTML ('<a class="menu-button">' + k + '</a>');
      menu.appendChild (a);
      a.onclick = h[k];
    }

  document.documentElement.appendChild (menu);

  menu.style.display = "block";
  menu.style.position = "absolute";
  menu.style.left = (e.layerX-10).toString () + "px";
  menu.style.top  = (e.layerY-10).toString () + "px";

  menu.addEventListener ("mouseleave", function () 
    {
      menu.remove ();
    }, false);

  return menu;
}

function _oncontextmenu (e)
{
  e.preventDefault ();
  console.log (e);

  let menu = getContextMenu (e, {"coucou": function () { alert ("coucou"); }, "dance": function () { alert ("dance"); }});

}

function numberLines ()
{
  let ns = document.evaluate ('//f:file', document, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
  
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

          let L = document.createElementNS (fxtranURI, "L");
          L.appendChild (document.createTextNode (("0000" + I).slice (-4) + " | "));
          s.parentNode.insertBefore (L, s.nextSibling);
          s.parentNode.insertBefore (document.createTextNode (t + "\n"), s.nextSibling);
          I++;

        }
      s.parentNode.removeChild (s);
    }
    
  f.removeChild (f.firstChild);
  f.removeChild (f.lastChild);
}

function _onload ()
{
  numberLines ();
  document.addEventListener ('click', _onclick);
  document.addEventListener ('contextmenu', _oncontextmenu);
}


