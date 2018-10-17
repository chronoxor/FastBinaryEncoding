from proto import test


def main():
    print(test.StructSimple().to_json() + '\n')
    print(test.StructOptional().to_json() + '\n')
    print(test.StructNested().to_json() + '\n')


if __name__ == "__main__":
    main()
