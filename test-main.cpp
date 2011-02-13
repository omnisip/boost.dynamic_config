#include "boost/dynamic_config/map_backend.hpp"
#include "boost/dynamic_config/property_config.hpp"
#include <boost/detail/lightweight_mutex.hpp>
#ifdef WIN32
#include "boost/dynamic_config/windows_registry_backend.hpp"
#endif
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
  assert(wrpc.insert(std::string("foobar"), 1));
  assert(wrpc.update("foobar", 4));
  assert(wrpc.select("foobar",val));
  assert(val == 4);
  assert(wrpc.remove("foobar"));
  assert(!wrpc.erase("foobar"));
  assert(wrpc.replace("foobar",7) == backend::insert);
  wrpc.clear();
#endif
}