module RequestsHelper
    def calculation(amounts)
        items = amounts.map{|a| a.item_id}
        prices = items.map{|a| Item.find(a).price}.sum()
    end
end
