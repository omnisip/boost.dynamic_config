#include "boost/dynamic_config/map_backend.hpp"
#include "boost/dynamic_config/property_config.hpp"
#include <boost/detail/lightweight_mutex.hpp>
#include <boost/exception/diagnostic_information.hpp>
#ifdef WIN32
#include "boost/dynamic_config/windows_registry_backend.hpp"
#endif
#include <iostream>
using namespace boost::dynamic_config;

#ifdef WIN32
struct dummy_mutex {
	typedef dummy_mutex scoped_lock;
};

typedef basic_property_config<windows_registry_backend,dummy_mutex> windows_registry_property_config;
#endif

typedef basic_property_config<map_backend,boost::detail::lightweight_mutex> map_property_config;

int main(int argc, char * argv[])
{
  map_property_config mpc;
  assert(mpc.insert(std::string("foobar"), 1));
  assert(mpc.update("foobar", 4));
  int val;
  assert(mpc.select("foobar",val));
  assert(val == 4);
  assert(mpc.remove("foobar"));
  assert(!mpc.erase("foobar"));
  assert(mpc.replace("foobar",7));
  
#ifdef WIN32


  windows_registry_property_config wrpc(TEXT("Boost"),TEXT("Dynamic Config"));
  wrpc.clear();
  assert(wrpc.insert(TEXT("foobar"), 1));
  assert(wrpc.update(TEXT("foobar"), 4));
  assert(wrpc.select(TEXT("foobar"),val));
  assert(val == 4);
  assert(wrpc.remove(TEXT("foobar")));
  assert(!wrpc.erase(TEXT("foobar")));
  assert(wrpc.replace(TEXT("foobar"),7) == backend::insert);
  assert(wrpc.replace(TEXT("foobar"), TEXT("blah")));
  assert(wrpc.insert(TEXT("double"), double(4.5)));
  double dVal;
  try {
  assert(wrpc.select(TEXT("double"),dVal));
  }
  catch (boost::exception & e)
  {
	  std::cout << boost::diagnostic_information(e) << std::endl;
	  throw;
  }
  std::cout << "Double value: " << dVal << std::endl;
  assert(wrpc.replace(TEXT("int"), 4) == backend::insert);
  //wrpc.clear();
#endif
}