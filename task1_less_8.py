"""
1. На улице встретились N друзей. Каждый пожал руку всем остальным друзьям
(по одному разу). Сколько рукопожатий было?
Примечание. Решите задачу при помощи построения графа.
"""


def fiends(count_friend):
    if count_friend < 2:
        return 'Должно быть больше друзей для рукопожатий'

    graph = []

    for i in range(count_friend):
        for j in range(count_friend):
            if i != j:
                graph.append((i, j))

    return len(graph) // 2


count_friend = int(input('Сколько друзей встретились: '))
print(f'Всего было {fiends(count_friend)} рукопожатий')
