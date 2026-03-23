package servlet;

import dao.CityDAO;
import dao.PlaceDAO;
import dao.ProductDAO;
import model.City;
import model.Place;
import model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


@WebServlet("/city")
public class CityServlet extends HttpServlet {

    private CityDAO    cityDAO;
    private PlaceDAO   placeDAO;
    private ProductDAO productDAO;

    @Override
    public void init() {
        cityDAO    = new CityDAO();
        placeDAO   = new PlaceDAO();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        int cityId;
        try {
            cityId = Integer.parseInt(idParam);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        try {
            City         city     = cityDAO.getCityById(cityId);
            List<City>   allCities = cityDAO.getAllCities();

            if (city == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "City not found");
                return;
            }

            // Check sort preference
            String sort = request.getParameter("sort");
            List<Place> places;
            if ("fee".equals(sort)) {
                places = placeDAO.getPlacesSortedByFee(cityId);
            } else {
                places = placeDAO.getPlacesByCity(cityId);
            }

            List<Product> products = productDAO.getProductsByCity(cityId);

            // Remember last visited city in session
            HttpSession session = request.getSession();
            session.setAttribute("lastCityId",   cityId);
            session.setAttribute("lastCityName", city.getName());

            // Pass data to JSP
            request.setAttribute("city",      city);
            request.setAttribute("allCities", allCities);
            request.setAttribute("places",    places);
            request.setAttribute("products",  products);
            request.setAttribute("sortMode",  sort != null ? sort : "name");

            request.getRequestDispatcher("/WEB-INF/city.jsp").forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Database error loading city details", e);
        }
    }
}
