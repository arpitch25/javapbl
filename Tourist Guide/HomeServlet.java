package servlet;

import dao.CityDAO;
import model.City;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private CityDAO cityDAO;

    @Override
    public void init() {
        cityDAO = new CityDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        List<City> cities;

        try {
            if (search != null && !search.trim().isEmpty()) {
                cities = cityDAO.searchCities(search.trim());
                request.setAttribute("searchQuery", search.trim());
            } else {
                cities = cityDAO.getAllCities();
            }
        } catch (SQLException e) {
            throw new ServletException("Database error loading cities", e);
        }

        // Store cities in request scope → JSP reads them
        request.setAttribute("cities", cities);

        // Track last visited city in session
        HttpSession session = request.getSession();
        Integer lastCityId = (Integer) session.getAttribute("lastCityId");
        if (lastCityId != null) {
            request.setAttribute("lastCityId", lastCityId);
        }

        // Forward to index.jsp
        request.getRequestDispatcher("/WEB-INF/index.jsp").forward(request, response);
    }
}
