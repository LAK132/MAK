#include <lak/file.hpp>

#include <iostream>

int main(int argc, const char **argv)
{
  ASSERT_EQUAL(argc, 2);

  lak::fs::path path = argv[1];

  DEBUG("Path: ", path);

  auto file = lak::read_file(path).unwrap();

  return 0;
}
