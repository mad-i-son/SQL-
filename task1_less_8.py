"""
1. �� ����� ����������� N ������. ������ ����� ���� ���� ��������� �������
(�� ������ ����). ������� ����������� ����?
����������. ������ ������ ��� ������ ���������� �����.
"""


def fiends(count_friend):
    if count_friend < 2:
        return '������ ���� ������ ������ ��� �����������'

    graph = []

    for i in range(count_friend):
        for j in range(count_friend):
            if i != j:
                graph.append((i, j))

    return len(graph) // 2


count_friend = int(input('������� ������ �����������: '))
print(f'����� ���� {fiends(count_friend)} �����������')
