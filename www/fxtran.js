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

function findNodes (xpath, node = document)
{
  return document.evaluate (xpath, node, nsResolver, XPathResult.ORDERED_NODE_SNAPSHOT_TYPE, null);
}


function highLight (t)
{
  let ns = findNodes ('//f:n[string(.)="' + t + '"]');
  let TT = parseHTML ('<tt style="background-color:red;"/>');

  for (let i = 0; i < ns.snapshotLength; i++)
    {
      let s = ns.snapshotItem (i);
      let tt = TT.cloneNode (true);
      let t = s.firstChild;
      tt.appendChild (t);
      s.appendChild (tt);
    }
}

function unHighLight (t)
{
  let ns = findNodes ('//f:n[string(.)="' + t + '"]');

  for (let i = 0; i < ns.snapshotLength; i++)
    {
      let s = ns.snapshotItem (i);
      if (s.firstChild.namespaceURI == htmlURI)
        {
          s.firstChild.replaceWith (s.firstChild.firstChild);
        }
    }
}

function nClick (n)
{
  let t = n.textContent;

  if (n.firstChild.namespaceURI == htmlURI)
    {
      unHighLight (t);
    }
  else
    {
      highLight (t);
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
      let kk = k;
      menu.appendChild (a);
      a.onclick = function () { h[kk].call (); menu.remove (); };
    }

  document.documentElement.appendChild (menu);

  menu.style.display = "block";
  menu.style.position = "absolute";
  menu.style.left = (e.layerX-10).toString () + "px";
  menu.style.top  = (e.layerY-10).toString () + "px";

  let clean;

  menu.addEventListener ("mouseleave", function () 
    {
      menu.remove ();
      document.removeEventListener ("keydown", clean, false);
    }, false);

  clean = function (e) 
  {
    if (e.key == 'Escape')
      {
        menu.remove ();
        document.removeEventListener ("keydown", clean, false);
      }
  };

  document.addEventListener ("keydown", clean, false);

  return menu;
}

function nContextMenu (n, e)
{
  getContextMenu (e, 
    {
      "HighLight"   : function () { let t = n.textContent;   highLight (t); },
      "UnHighLight" : function () { let t = n.textContent; unHighLight (t); },
    });
}

function wrapTag (t, n)
{
  t.replaceWith (n);
  n.appendChild (t);
}

function unWrapTag (t)
{
  t.parentNode.replaceWith (t);
}

function callStmtFold (n)
{
  let ns = findNodes ('./f:arg-spec', n);
  if (ns.snapshotLength)
    {
      wrapTag (ns.snapshotItem (0), parseHTML ('<tt style="display: none;"/>'));
    }
}

function callStmtUnFold (n)
{
  let ns = findNodes ('./html:*/f:arg-spec', n);
  if (ns.snapshotLength)
    {
      unWrapTag (ns.snapshotItem (0));
    }
}

function callStmtContextMenu (n, e)
{

  getContextMenu (e, 
    {
      "Fold"   : function () { callStmtFold   (n); },
      "UnFold" : function () { callStmtUnFold (n); },
    });
}

function _oncontextmenu (e)
{
  
  let n = e.target;

  let a = findTarget ('ContextMenu', n);

  if (a)
    {
      e.preventDefault ();
      methodCall (a["method"], a["node"], e);
    }

}

function numberLines ()
{
  let ns = findNodes ('//f:file');
  
  let f = ns.snapshotItem (0);
  
  f.insertBefore (document.createTextNode ("\n"), f.firstChild);
    
  ns = findNodes ('//f:file//text()[contains(.,"\n")]');
                
  let I = 1;                            
  for (let i = 0; i < ns.snapshotLength; i++)
    {
      let s = ns.snapshotItem (i);
      let t = s.textContent;
      let tt = t.split (/\n/);
      let nsi = s.nextSibling;

      let ll = tt.pop ();

      for (t of tt)
        {
          let L = document.createElementNS (fxtranURI, "L");
          L.appendChild (document.createTextNode (("0000" + I).slice (-4) + " | "));
          let tn = document.createTextNode (t + "\n");
          s.parentNode.insertBefore (tn, nsi);
          s.parentNode.insertBefore (L, nsi);
          I++;
        }

      ll = document.createTextNode (ll);
      s.parentNode.insertBefore (ll, nsi);
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


