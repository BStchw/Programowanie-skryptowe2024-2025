import random
import yaml


def introduce_typos(text):
    """Wprowadza losowe literówki do tekstu"""
    typo_probability = 0.2  # 20% szansy na błąd w każdym słowie
    words = text.split()
    for i in range(len(words)):
        if random.random() < typo_probability:
            if len(words[i]) > 3:
                char_list = list(words[i])
                index = random.randint(0, len(char_list) - 2)
                char_list[index], char_list[index + 1] = char_list[index + 1], char_list[index]  # Zamiana liter
                words[i] = "".join(char_list)
    return " ".join(words)


def augment_dataset(dataset):
    """Tworzy rozszerzony zbiór danych z literówkami"""
    return [introduce_typos(sentence) for sentence in dataset]


def update_nlu_file(nlu_file_path):
    """Dodaje literówki do istniejących intencji w pliku nlu.yml"""
    with open(nlu_file_path, "r", encoding="utf-8") as file:
        nlu_data = yaml.safe_load(file)

    for intent_data in nlu_data["nlu"]:
        if "examples" in intent_data:
            examples = intent_data["examples"].strip().split("\n")
            typo_examples = augment_dataset(examples)  # Użycie funkcji augment_dataset
            intent_data["examples"] += "\n" + "\n".join(typo_examples)

    with open(nlu_file_path, "w", encoding="utf-8") as file:
        yaml.dump(nlu_data, file, allow_unicode=True, default_flow_style=False)


if __name__ == "__main__":
    update_nlu_file("data/nlu.yml")  # Aktualizacja datasetu z literówkami
