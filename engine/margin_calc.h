#include <vector>

/*
	btw I've never thought I'd need to use inline
	everywhere, like it was just for fun, but now I get
	LNK2005 errors if I don't use it here ¯\_(ツ)_/¯
*/

namespace MARGIN
{
	/*
		so if there are n clients, each client gets assigned
		their own index in BI, which tells them which
		margins to use from the top, bottom, left, right
	*/
	inline std::vector<std::vector<int>> bi_list = {
		{0, 2, 8}, // 3
		{0, 2, 5, 8}, // 4
		{0, 2, 4, 6, 8}, // 5
		{0, 1, 3, 5, 7, 9}, // 6
		{0, 1, 3, 4, 6, 7, 9}, // 7
		{0, 1, 2, 3, 5, 7, 8, 9}, // 8
		{0, 1, 2, 3, 4, 6, 7, 8, 9}, // 9
		{0, 1, 2, 3, 4, 5, 6, 7, 8, 9} // 10
	};

	inline bool isInitialized = false;
	inline std::vector<int> BI;
	inline std::vector<int> top = { -1, -1, -1, 141, 28, 28, 28, 141, -1, -1 };
	inline std::vector<int> bottom = { 15, 265, -1, -1, -1, -1, -1, -1, -1, 265 };
	inline std::vector<int> left = { -1, 15, 15, 15, 395, -1, -1, -1, -1, -1 };
	inline std::vector<int> right = { -1, -1, -1, -1, -1, -1, 395, 15, 15, 15 };

	inline void init_and_rotate(int size, int clientIndex)
	{
		if (size < 3 || size > 10) return;
		BI = bi_list[size - 3];
		clientIndex = clientIndex % size; // just in case
		std::rotate(BI.begin(), BI.end() - clientIndex, BI.end());
		isInitialized = true;
	}
}
