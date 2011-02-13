#include "boost/dynamic_config/map_backend.hpp"
#include "boost/dynamic_config/property_config.hpp"
#include <boost/detail/lightweight_mutex.hpp>
using namespace boost::dynamic_config;

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
  
}