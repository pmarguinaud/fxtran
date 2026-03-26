_U2S = {
    'assignment': 'a',
    'dimension':  'DIM',
    'entity':     'EN',
    'expr':       'E',
    'global':     'G',
    'kind':       'K',
    'list':       'LT',
    'local':      'LC',
    'name':       'N',
    'namespace':  'NS',
    'object':     'obj',
    'operator':   'op',
    'ref':        'R',
    'symbol':     'S',
    'type':       'T',
    'variable':   'V',
}

_S2U = {v: k for k, v in _U2S.items()}


def lookup_u2s(x):
    if x not in _U2S:
        parts = x.split('-')
        parts = [_U2S.get(p, p) for p in parts]
        result = '-'.join(parts)
        _U2S[x] = result
        _S2U[result] = x
    return _U2S[x]


def lookup_s2u(x):
    if x not in _S2U:
        parts = x.split('-')
        parts = [_S2U.get(p, p) for p in parts]
        result = '-'.join(parts)
        _S2U[x] = result
        _U2S[result] = x
    return _S2U[x]
