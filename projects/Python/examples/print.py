from proto import test


def main():
    print(str(test.StructSimple()) + '\n')
    print(str(test.StructOptional()) + '\n')
    print(str(test.StructNested()) + '\n')


if __name__ == "__main__":
    main()
