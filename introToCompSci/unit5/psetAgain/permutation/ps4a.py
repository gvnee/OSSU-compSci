def get_permutations(sequence):

    if len(sequence) == 1:
        return [sequence]
    
    l = []
    for s in get_permutations(sequence[1:]):
        for i in range(len(s) + 1):
            l.append(s[:i] + sequence[0] + s[i:])
    return l

print(get_permutations("bust"))