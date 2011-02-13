#ifndef BOOST_DYNAMIC_CONFIG_BACKEND_HPP
#define BOOST_DYNAMIC_CONFIG_BACKEND_HPP 1
#include <boost/config.hpp>
#include <boost/detail/workaround.hpp>
//
//  backend.hpp -- Backend for Dynamic Config System
//
//  Copyright (C) 2011 Dan Weber <dan@marketsoup.com>
//
// Distributed under the Boost Software License, Version 1.0. (See
// accompanying file LICENSE_1_0.txt or copy at
// http://www.boost.org/LICENSE_1_0.txt)
//
//
namespace boost {
namespace dynamic_config {

	class backend {
	public:
		enum operation_performed {
			none, // e.g. no value changed
			insert,
			update
		};
		//static const bool has_builtin_replace = false;

		/*
		bool insert(basic_string<CharT> key, (int, basic_string<CharT>, bool, int64_t, char) value); // These values may be easily implementable with boost::variant, or separately if enable_if is used.
		bool update(basic_string<CharT> key, (see above..) value);
		// Note this returns operation performed because optional locking will be done around these functions, so combining insert with update replaces a possible race condition over those 2 operations performed separately
		operation_performed replace(basic_string<CharT> key, (...) value);
		template <T> bool select(basic_string<CharT> key, T& value); // returns success if retrieved, this can also use boost::optional otherwise
		bool delete(basic_string<CharT> key, bool cascade); // cascade takes effect if key takes a whole tree with it
		*/
	};
	
}
}

#endif // BOOST_DYNAMIC_CONFIG_BACKEND_HPP