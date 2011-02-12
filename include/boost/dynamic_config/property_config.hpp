#ifndef BOOST_DYNAMIC_CONFIG_PROPERTY_CONFIG_HPP
#define BOOST_DYNAMIC_CONFIG_PROPERTY_CONFIG_HPP 1
//
//  property_config.hpp -- Main class for property_configuration
//
//  Copyright (C) 2011 Dan Weber <dan@marketsoup.com>
//
// Distributed under the Boost Software License, Version 1.0. (See
// accompanying file LICENSE_1_0.txt or copy at
// http://www.boost.org/LICENSE_1_0.txt)
//
//
#include <boost/config.hpp>
#include <boost/detail/workaround.hpp>
#include <boost/noncopyable.hpp>
#include <boost/dynamic_config/backend.hpp>
#include <string>
namespace boost {
namespace dynamic_config {
template <typename CharT, typename Backend, typename Mutex>
class basic_property_config : boost::noncopyable {
public:
    typedef std::basic_string<CharT> string_type;
	/// Constructors
	property_config();
	property_config(string_type const & organizationName, string_type const & applicationName); // Pretty much required for use in the windows registry and in firefox

	~property_config();

	size_type erase(string_type key);
	void clear();
	template<typename T> bool find(string_type const & key, T & value);
	template<typename T> bool insert(string_type const & key, T value);
	template<typename T> bool update(string_type const & key, T value);
	template<typename T> backend::operation_performed replace(string_type const & key, T value);
	template<typename T> bool select(string_type key, T& value);
	template<typename T> bool delete(string_type key,  T value);


};
} // dynamic_config
} // boost


#endif // BOOST_DYNAMIC_CONFIG_PROPERTY_CONFIG_HPP