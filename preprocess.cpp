#include <string>
#include <fstream>
#include <streambuf>
#include <iostream>

std::string removeComments(std::string);

int main(int argc, char **argv) {
  std::ifstream t(argv[1]);
  std::string str((std::istreambuf_iterator<char>(t)),
                 std::istreambuf_iterator<char>());
  std::cout << removeComments(str);
  return 0;
}

std::string removeComments(std::string prgm) {
  int n = prgm.length();
  std::string res;
  bool s_cmt = false;
  bool m_cmt = false;

  for (int i=0; i<n; i++) {
    if (s_cmt == true && prgm[i] == '\n') 
      s_cmt = false;
    else if (m_cmt == true && prgm[i] == '*' && prgm[i+1] == '/') 
      m_cmt = false, ++i;
    else if (s_cmt || m_cmt) 
      continue;
    else if (prgm[i] == '/' && prgm[i+1] == '/') 
      s_cmt = true, ++i;
    else if (prgm[i] == '/' && prgm[i+1] == '*') 
      m_cmt = true, ++i;
    else res += prgm[i];
  }
  return res.c_str();
}

